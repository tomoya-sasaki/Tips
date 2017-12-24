for (int i=0; i<numItns; i++) {

  double denominator = 0.0;
  double currentDigamma = 0.0;

  for (int n=1; n<topicDocNormHist.length; n++) {
    currentDigamma += 1.0 / (paramSum + n - 1);
    denominator += topicDocNormHist[n] * currentDigamma;
  }

  paramSum = 0.0;

  for (int j=0; j<T; j++) {

    int limit = limits[j];

    double oldParam = param[j];
    param[j] = 0.0;
    currentDigamma = 0;

    for (int n=1; n<=limit; n++) {
      currentDigamma += 1.0 / (oldParam + n - 1);
      param[j] += topicDocHist[j][n] * currentDigamma;
    }

    param[j] *= oldParam / denominator;

    if (param[j] == 0.0)
      param[j] = 1e-10;

    paramSum += param[j];
  }
}