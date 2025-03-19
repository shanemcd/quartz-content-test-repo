### What is this repo?

This repo was created to test out the ability to store content for a [Quartz](http://quartz.jzhao.xyz) site
in a separate Git repository. The issue was reported in https://github.com/jackyzha0/quartz/issues/1857.

### How to use this repo

Prerequisites:

- `make`
- `docker` or `podman`

To test this out, simply run this command from the root of this repo:

```
$ make
```

Note the output contains:

```
Warning: /repo/content/index.md isn't yet tracked by git, dates will be
inaccurate
```

Now if we re-run the same command pointed to a branch with the fix, the warning
goes away:

```
QUARTZ_FORK=shanemcd QUARTZ_REF=git-the-right-date make -B
```

### How to test changes to Quartz

By setting the `QUARTZ_REPO_PATH` environment variable, we can mount our local
copy of Quartz into our test container.

**Note** you will need to set `defaultDateType: "modified",` in
`quartz.config.ts` for this to work properly.

```
QUARTZ_REPO_PATH=$HOME/github/jackyzha0/quartz make
```

Note that this will require the node dependecies to be present in order to
work. If you don't have node installed locally on your host machine (like me),
you can run:

```
QUARTZ_REPO_PATH=$HOME/github/jackyzha0/quartz make debug
```

Then inside of the container run `npm ci`, exit, then re-run the command above
without `debug`.
