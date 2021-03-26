final: prev: {
  devosOptionsDoc = (prev.lib.dev.evalFlakeArgs { args = {}; }).genDoc prev;
}
