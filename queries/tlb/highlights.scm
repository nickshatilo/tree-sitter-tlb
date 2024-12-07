;; highlights.scm

;; Comments
(comment) @comment

;; Identifiers & Types
(identifier) @variable
(type_identifier) @type

;; Builtin operators
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
(declaration (constructor (constructor_tag) @number)) ; if constructor_tag is numeric
(constructor_name) @function
(constructor_tag) @number
(combinator (identifier) @function)

;; Fields
(field_named_def (identifier) @field)
(field_anonymous_def) @field

;; Expressions & Operators
(negate_expression "~") @operator

;; Comparison operators (one per line)
(comparison_expression "=") @operator
(comparison_expression "<") @operator
(comparison_expression ">") @operator
(comparison_expression "<=") @operator
(comparison_expression ">=") @operator
(comparison_expression "!=") @operator

;; Math operators
(math_expression "+") @operator
(math_expression "-") @operator
(math_expression "*") @operator
(math_expression "/") @operator

;; Conditional operator
(conditional_expression "?") @operator

;; Bit selection operator
(bit_selection_expression ".") @operator

;; Type math operators
(type_math_expression "+") @operator
(type_math_expression "-") @operator
(type_math_expression "*") @operator
(type_math_expression "/") @operator

;; Cell reference operator
(cell_ref_expression "^") @operator

;; Parenthesized expressions & type expressions
(parenthesized_expression "(") @punctuation.delimiter
(parenthesized_expression ")") @punctuation.delimiter
(parenthesized_type_expression "(") @punctuation.delimiter
(parenthesized_type_expression ")") @punctuation.delimiter

;; Type applications & arguments
(type_application (identifier) @type)
(parenthesized_type_application (identifier) @type)

;; Keywords & Built-in Types
"Any" @type.builtin
"Type" @type.builtin

;; Match known built-in types by name
((identifier) @type.builtin
 (#match? @type.builtin "^(Cell|Int|UInt|Bits|Maybe|Either|Both|Unary|Hashmap(E|Aug(E)?)?|PfxHashmap(E)?|VarHashmap(E)?|BinTree(Aug)?|Any|Type)$"))

;; Match parametrized built-in numeric types (uintX, intX, bitsX)
((identifier) @type.builtin
 (#match? @type.builtin "^(uint[0-9]+|int[0-9]+|bits[0-9]+)$"))
