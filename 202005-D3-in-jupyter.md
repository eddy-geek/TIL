# Custom D3.js Visualization in a Jupyter Notebook, behind a firewall

Importing D3 directly in `Javascript('<script src="...">')` does not work (anymore? several web resources still advise it).

for example:

```
%%javascript
d3
```

```
    Javascript error adding output!
    ReferenceError: d3 is not defined
    See your browser Javascript console for more details.
```

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

This can be further simplified with py_d3 which, in theory, [allows custom URLs](https://github.com/ResidentMario/py_d3/pull/11) -- important for me as I'm behind a firewall -- but I was not able to get it work for me.

So, how to handle the firewall? Downloading d3.v5.min.js is easy but:

### What worked
...was to use jupyter to serve it though the `/files/...` endpoint.

Say that 
* your notebook root URL (tree explorer) is https://jupyter.notebook.net/tree/, 
* and that you can access the folder containing d3.min.js through https://jupyter.notebook.net/tree/foo/bar/.

Then the URL to put is `d3: 'https://jupyter.notebook.net/files/foo/bar/d3.v5.min'`

**(!) A refresh may be necessary between executing the RequireJS cell and actually displaying something.**

### What did not work?

I was not able to point RequireJS to a local path. This makes sense in retrospect, as this is executed client-side.

### What made it hard to get this working?

Mostly lack of direct feedback from the notebook.

```javascript
%%javascript
element.text('hello world');
```
`   hello world`

but

```javascript
%%javascript
require.config({
    paths: {
        d3: 'some not working URL'
    }
});
```

will seem to succeed and just silently break later, with no errors ever displayed:

```javascript
%%javascript
    require(['d3'], function(d3) {   
        element.text('hello world');
    })
```

The console displays

```javascript
require.js?v=951f856e81496aaeec2e71a1c2c0d51f:168 Uncaught Error: Script error for "d3"
http://requirejs.org/docs/errors.html#scripterror
    at makeError (require.js?v=951f856e81496aaeec2e71a1c2c0d51f:168)
    at HTMLScriptElement.onScriptError (require.js?v=951f856e81496aaeec2e71a1c2c0d51f:1735)
```
which is not very helpful

Then as mentioned, a refresh was necessary between executing the RequireJS cell and actually displaying something. Subsequent cells "suceeded" but had no visible output, then F5 immediately displayed the expected output (e.g. d3 viz) without rerunning. Tricky.

On the plus side, I did not need the `(function(element) { ... })` trick, each cell was only affecting its own output even after a refresh.
