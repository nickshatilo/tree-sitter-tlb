# tree-sitter-tlb

A Tree-sitter grammar for the [TL-B](https://docs.ton.org/v3/documentation/data-formats/tlb/tl-b-language) language.

Includes nvim bindings.


## Installation

Lazy.nvim:

```lua
    {
        'nickshatilo/tree-sitter-tlb',
        lazy = false,
        opts = {},
    }
```

Then, just run `:TSInstall tlb` 

## Grammar references

* [Official docs](https://docs.ton.org/v3/documentation/data-formats/tlb/tl-b-language)
* [TL-B parser](https://github.com/ton-community/tlb-parser)
* [Native TL-B types](https://github.com/ton-blockchain/ton/blob/master/crypto/block/block.tlb)

## Func comments injections

I also like to have TL-B schemes highlighted right inside func files, so if you want you could add the following to your ~/.config/nvim/queries/func/injections.scm file:

```
(
  (comment) @injection.content
  (#match? @injection.content "\\{-TLB(.*)-\\}")
  (#offset! @injection.content 0 5 0 -2)
  (#set! injection.language "tlb")
)
```

So inside func files you could have highlighting inside the comments:

```func
{-TLB
    addr_none$00 = MsgAddressExt;
-}
```

## TODO:

* Add TL-B into official [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) grammars

