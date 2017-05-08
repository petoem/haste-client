# haste client
CLI client for haste-server written in crystal based on [haste-client](https://github.com/seejohnrun/haste-client).

haste is a client for uploading data to haste-server. All you have to do is pipe data into STDIN:

`cat file | haste`

After that, it will print the URL to STDOUT.

This can be used in combination with `pbcopy`, like:

* mac osx: `cat file | haste | pbcopy`
* linux: `cat file | haste | xsel`

after which the contents of `file` will be accessible at a URL which has been copied to your clipboard.

## Installation

Download the executable from release page and put it in your path.

## Usage

### Making uploading file contents easier

If you supply a valid file path as the first argument to the client, the file will be taken as input:

``` bash
# equivalent
cat file | haste
haste file
```

### You can get the raw version

Want a URL pointing to a plain-text version instead?

``` bash
cat file | haste --raw # or
haste file --raw
```

## Contributing

1. Fork it ( https://github.com/petoem/haste-client/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [petoem](https://github.com/petoem) Michael Petö - creator, maintainer
