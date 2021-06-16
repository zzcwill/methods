function myApiFunc(callback)
{
/*
 * This pattern does NOT work!
 */
try {
  doSomeAsynchronousOperation(function (err) {
    if (err)
      throw (err);
    /* continue as normal */
  });
} catch (ex) {
  callback(ex);
}
}