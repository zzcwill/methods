let ctx = {
  body: {
    name: '',
    password: 'zzc'
  }
}

// 是否为手机号
function isPhone(str) {
  const reg = /0?(1)[0-9]{10}/
  return reg.test(str)
}
function isEmpty(str) {
  if (str !== '') {
    return false
  }
  return true
}
function isLength(str, option) {
  let deafultOption = {
    min: 1,
    max: 1000
  }

  let setOption = Object.assign(deafultOption, option)

  let length = str.length

  if (length < setOption.min) {
    return false
  }
  if (length > setOption.max) {
    return false
  }
  return true
}

class Validator {
  constructor() {
    this.data = {}
  }

  findMembers(instance, { filter }) {
    // 递归函数
    function _find(instance) {
      //基线条件（跳出递归）
      if (instance.__proto__ === null)
        return []

      let names = Reflect.ownKeys(instance)
      names = names.filter((name) => {
        // 过滤掉不满足条件的属性或方法名
        return _shouldKeep(name)
      })

      return [...names, ..._find(instance.__proto__)]
    }

    function _shouldKeep(value) {
      if (filter) {
        if (filter(value)) {
          return true
        }
      }
    }

    return _find(instance)
  }

  _findMembersFilter(key) {
    if (this[key] instanceof Array) {
      this[key].forEach(value => {
        const isRuleType = value instanceof Rule
        if (!isRuleType) {
          throw new Error('验证数组必须全部为Rule类型')
        }
      })
      return true
    }
    return false
  }

  async _check(key) {
    // 属性验证, 数组，内有一组Rule
    const rules = this[key]
    let paramValue = this.data[key]
    let result
    for (let rule of rules) {
      if(rule.options) {
        result = rule.ruleFn(paramValue,rule.options)
      }
      if(!rule.options) {
        result = rule.ruleFn(paramValue)
      }      

      if (!result) {
        // 一旦一条校验规则不通过，则立即终止这个字段的验证
        return {
          msg: rule.msg,
          success: false          
        }
      }
    }

    return {
      msg: 'ok',
      success: true
    }
  }

  async validate(ctx) {
    this.data = Object.assign(this.data, ctx.body)

    const memberKeys = this.findMembers(this, {
      filter: this._findMembersFilter.bind(this)
    })

    const errorMsgs = []

    for (let key of memberKeys) {
      const result = await this._check(key)
      if (!result.success) {
        errorMsgs.push(result.msg)
      }
    }
    if (errorMsgs.length != 0) {
      console.info(errorMsgs)
    }

    return this
  }
}

class Rule {
  constructor(ruleFn, msg, options) {
    Object.assign(this, {
      ruleFn,
      msg,
      options
    })
  }
}

class LoginValidator extends Validator {
  constructor() {
    super();
    this.name = [
      new Rule(isEmpty, '用户名不能为空'),
      new Rule(isPhone, '请输入正确的手机号'),
    ]
    this.password = [
      // 用户密码指定范围
      new Rule(isEmpty, '用户名不能为空'),
      new Rule(isLength, '密码至少6个字符，最多22个字符', {
        min: 6,
        max: 22
      })
    ]
  }
}

new LoginValidator().validate(ctx)
