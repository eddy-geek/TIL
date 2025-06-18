# Personal RAG server specs

## Specs

* Search flow
  * A tiny search-box, just a simple text box.
  * Does fast as-you-type hybrid (semantic+URL+title) search inside the database.
  * Keyboard navigation into the results.
  * Clicking a result will open the default browser.
    * This can be combined with a browser-selector, like Linkquisition for Linux or
      [any from this thread](https://www.reddit.com/r/MacOS/comments/11xcj1z/is_there_a_browser_selector_for_macos/) for macos.

Search backend: 

I am not sure yet if a full-fledged Vector DB is used:

* for the fast cross-browser bookmark need, something like smart-bookmark (below) --
  were AI is only at bookmark creation time -- would be enough, ease integration, x-device sync, and be lower-latency.
* otoh, ability to scale-up to personal RAG engine is exciting.

## Resources

* [gildas-lormeau/SingleFile](https://github.com/gildas-lormeau/SingleFile):
  Web Extension and CLI for saving a faithful copy of a complete web page in a single HTML file
You can execute a user script just before (and after) SingleFile saves a page. Doc
[here](https://github.com/gildas-lormeau/SingleFile/wiki/How-to-execute-a-user-script-before-a-page-is-saved).


* [SciPhi-AI/R2R](https://github.com/SciPhi-AI/R2R) :
  "SoTA production-ready AI retrieval system. Agentic Retrieval-Augmented Generation (RAG) with a RESTful API."

Other: 

* [open-webui/open-webui](https://github.com/open-webui/open-webui) : User-friendly AI Interface (Supports Ollama, OpenAI API, ...)

* [dh1011/semantic-bookmark-manager](https://github.com/dh1011/semantic-bookmark-manager):
  A simple web application that simplifies bookmark management through semantic search.
* [dh1011/smart-bookmark](https://github.com/dh1011/smart-bookmark):
  Smart Bookmark is a simple, AI-powered tool to help you stay organized and make the most of your bookmarks.
  Features like smart search, automatic summaries, and tagging make it easy to search and organize your bookmarks.

  Low-leel:

* Stop the Hallucinations: Hybrid Retrieval with BM25, pgvector, embedding rerank, LLM Rubric Rerank &amp; HyDE | by Rick Hightower | May, 2025 | [Medium](https://medium.com/@richardhightower/stop-the-hallucinations-hybrid-retrieval-with-bm25-pgvector-embedding-rerank-llm-rubric-rerank-895d8f7c7242)
