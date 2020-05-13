
Importing D3 directly in `Javascript('<script src="...">')` does not work.

The approach that does work is to use Jupyter notebook's built-in RequireJS, as described by Stefaan Lippens' [Custom D3.js Visualization in a Jupyter Notebook](https://www.stefaanlippens.net/jupyter-custom-d3-visualization.html) and livingwithmachines' [D3 JavaScript visualisation in a Python Jupyter notebook](http://livingwithmachines.ac.uk/d3-javascript-visualisation-in-a-python-jupyter-notebook/)

> First, we tell the RequireJS environment where to find the version of D3.js we want. Note that the .js extension is omitted in the URL.

```javascript
%%javascript
require.config({
    paths: {
        d3: 'https://d3js.org/d3.v5.min'
    }
});
```

(alternatively `from IPython.display import Javascript` also works)

This can be further simplified with py_d3 which [allows custom URLs](https://github.com/ResidentMario/py_d3/pull/11) (important for me as I'm behind a firewall).

Now, how to handle the firewall? Downloading d3.v5.min.js is easy but I was able to point RequireJSto a local path. I also tried the jupyter-provided `/files/...` endpoint but without success, I was too lazy to debug it, a bare wget does not work due to missing Origin which breaks a CORS-like server-side check.
