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

Bookmark managers

[Self-Hosting Guide to Alternatives: Pocket, Omnivore](https://selfh.st/alternatives/read-later/)

> **Linkwarden**: extensive support for third-party integrations. webpage screenshots, Wayback Machine archiving, organization via collections and tags, sharing, pinning, multi-user capabilities with SSO, and a ton of customization options.
> ton of support for adding bookmarks via third-party tools, which include Floccus sync, desktop apps, Raycast support, and browser extensions. Linkwarden can be installed via bare metal or Docker and requires a PostgreSQL DB.

> **Karakeep** : first release early 2024. Unlike some of the other alternatives, it aims to be an all-encompassing platform for data hoarders with support for features like OCR extraction, simple note-taking functionality, and video archiving via youtube-dl.
> Given its extensive functionality, Hoarder requires a bit more overhead to deploy than the others but provides clear instructions on how to do so easily via Docker. 

* **[linkwarden/linkwarden](https://github.com/linkwarden/linkwarden)** [13k gh*]:
  Self-hosted collaborative bookmark manager to collect, organize, and preserve webpages, articles, and documents.
  PWA ; Browser extensions ; Mobile apps. [HN thread](https://news.ycombinator.com/item?id=43856801) "while it is smaller than karakeep/hoarder, for me it consumes 500-950MB ram"
* [Floccus bookmarks sync](https://floccus.org/guides) can work with Linkwarden and GDrive to sync bookmarks cross-browser
* [sissbruecker/linkding: Self-hosted bookmark manager that is designed be to be minimal, fast, and easy to set up using Docker.](https://github.com/sissbruecker/linkding) - too minimalist
* [karakeep](https://github.com/karakeep-app/karakeep) [17k gh*] - (prev. named Hoarder)
  * in-depth guide/review [jameskilby](https://jameskilby.co.uk/2025/01/how-i-migrated-from-pocket-to-hoarder-and-introduced-some-ai-along-the-way/)

Linkwarden vs karakeep

> I’d personally stick with Linkwarden. Karakeep feels a bit all over the place, trying to combine bookmarks, images, and notes into one app. Since I already use Immich for photos and videos, and Obsidian for notes, I just wanted something simple and focused for bookmarks. Linkwarden does that really well, and I find the interface nicer too. It doesn’t have an official mobile app yet, but it works great for what I need.

> They're both kinda shit in my opinion.
> Linkwarden has the UI Design of a 2000s app. 30% of the dashboard are wasted with a non-clickable bragboard how many articles you collected. Customizability zero. You can create Folders/Categories but for some absolutely stupid design reason the developer choose to make the icons all unicolor.
> Karakeep has a way more intuitive GUI and better functions like Ai tagging and link description etc. But it's not there yet. Most articles which I saved couldn't generate a banner picture. Karakeep cannot pass cookie banner while fetching a site so all websites out of the EU are basically unavailable to fetch. You cannot even fetch a simple reddit post because it's blocked by a large cookie terms banner. Also the mobile app is not usable at the moment as it lacks basic functionality.
> Right now functionality wise raindrop.io is the most sophisticated link grabber. But it's not selfhosted and also not free if you want to save articles offline. In raindrop you can also upload your own icons for categories of your liking. The app on ios and android is near perfect. 
> I hope karakeep reaches a certain maturity in a couple of years. For linkwarden I have no hope, the GUI is horrible, icons included.

RAG:

* [txtai](https://neuml.github.io/txtai/) [11k gh*]: all-in-one AI framework for semantic search, LLM orchestration and language model workflows.
  "...commitment to quality and performance, especially with local models. For example, it's vector embeddings component streams vectors to disk during indexing and uses mmaped arrays to enable indexing large datasets locally on a single node"
* [SciPhi-AI/R2R](https://github.com/SciPhi-AI/R2R)  [7k gh*]:
  "SoTA production-ready AI retrieval system. Agentic Retrieval-Augmented Generation (RAG) with a RESTful API."
* [morphik-org/morphik-core](https://github.com/morphik-org/morphik-core) [3k gh*]: Open source SDK with multi-modal RAG for building AI apps over private knowledge. UI is closed.

Other: 

* [open-webui/open-webui](https://github.com/open-webui/open-webui) : User-friendly AI Interface (Supports Ollama, OpenAI API, ...)

* [dh1011/semantic-bookmark-manager](https://github.com/dh1011/semantic-bookmark-manager):
  A simple web application that simplifies bookmark management through semantic search.
* [dh1011/smart-bookmark](https://github.com/dh1011/smart-bookmark):
  Smart Bookmark is a simple, AI-powered tool to help you stay organized and make the most of your bookmarks.
  Features like smart search, automatic summaries, and tagging make it easy to search and organize your bookmarks.

Low-level:

* [langroid/langroid](https://github.com/langroid/langroid): principled Python Agentic framework to easily build LLM-powered applications

* Stop the Hallucinations: Hybrid Retrieval with BM25, pgvector, embedding rerank, LLM Rubric Rerank &amp; HyDE | by Rick Hightower | May, 2025 | [Medium](https://medium.com/@richardhightower/stop-the-hallucinations-hybrid-retrieval-with-bm25-pgvector-embedding-rerank-llm-rubric-rerank-895d8f7c7242)

* In supabase free tier of 500 MB I can store 20k pages with their full text content (3500 words -> 20 KB per page)
