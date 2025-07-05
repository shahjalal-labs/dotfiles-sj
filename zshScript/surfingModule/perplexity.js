// perplexity.js
export function initPerplexityKey() {
  api.mapkey("ax", "perplexity ai", function () {
    if (window.location.hostname.includes("perplexity")) {
      window.location.href = "https://www.perplexity.ai/";
    } else {
      window.open("https://www.perplexity.ai/", "_blank");
    }
  });
}
