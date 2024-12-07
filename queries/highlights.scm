;; Comments
(comment) @comment

;; Basic tokens & identifiers
(identifier) @variable
(type_identifier) @type
(_number) @number
(_hex_number) @number
(_binary_number) @number

;; Builtin operators (#, ##, #<, #<=, lenBits)
(builtin_operator) @operator.builtin
(builtins_zero_args) @operator.builtin

;; Punctuation & delimiters
"=" @punctuation.delimiter
":" @punctuation.delimiter
"(" @punctuation.delimiter
")" @punctuation.delimiter
"{" @punctuation.delimiter
"}" @punctuation.delimiter
"[" @punctuation.delimiter
"]" @punctuation.delimiter
";" @punctuation.delimiter
"." @punctuation.delimiter
"!" @punctuation.special

;; Constructors & combinators
(declaration (constructor (constructor_name) @function))
(declaration (constructor (constructor_tag) @number))
(constructor_name) @function
(constructor_tag) @number
(combinator (identifier) @function)

;; Field definitions
(field_named_def (identifier) @field)
(field_anonymous_def) @field

;; Expressions & operators inside expressions
(negate_expression "~") @operator
(comparison_expression
  ("=" | "<" | ">" | "<=" | ">=" | "!=") @operator)

(math_expression
  ("+" | "*") @operator)

(conditional_expression
  "?" @operator)

(bit_selection_expression ".") @operator

(type_math_expression
  ("+" | "*") @operator)

;; Builtin expressions & cell refs
(builtin_expression) @function.builtin
(cell_ref_expression "^") @operator

;; Parenthesized expressions & type expressions
(parenthesized_expression "(" @punctuation.delimiter)
(parenthesized_expression ")" @punctuation.delimiter)
(parenthesized_type_expression "(" @punctuation.delimiter)
(parenthesized_type_expression ")" @punctuation.delimiter)

;; Type applications & arguments
(type_application (identifier) @type)
(parenthesized_type_application (identifier) @type)

;; Keywords and special words
"Any" @type.builtin
"Type" @type.builtin

;; Match known built-in types by name
((identifier) @type.builtin
 (#match? @type.builtin "^(Cell|Int|UInt|Bits|Maybe|Either|Both|Unary|Hashmap(E|Aug(E)?)?|PfxHashmap(E)?|VarHashmap(E)?|BinTree(Aug)?|Any)$"))

;; Match parametrized built-in numeric types (uintX, intX, bitsX)
((identifier) @type.builtin
 (#match? @type.builtin "^(uint[0-9]+|int[0-9]+|bits[0-9]+)$"))
