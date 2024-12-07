module.exports = grammar({
  name: 'tlb',

  extras: $ => [
    $.comment,
    /\s/
  ],

  conflicts: $ => [
    [$._ref_expression, $.type_application],
    [$.field_anonymous_def],
    [$._type_expression, $._type_expression_no_application],
    [$._field_value, $._type_expression],
    [$._expression, $._type_expression],
    [$._type_app_argument, $._simple_type_expr],
    [$.builtin_expression, $._ref_expression],
    [$._type_expression, $.builtins_zero_args],
    [$._field_value, $._expression],
  ],

  precedences: _ => [
    ['sequence'],
    ['declaration'],
    ['combinator_args'],
    ['comparison'],
    ['type_math'],
    ['math'],
    ['conditional'],
    ['application'],
    ['cell_ref'],
    ['prefix', 'unary'],
    ['primary'],
    ['atom'],
  ],

  rules: {
    program: $ => repeat($._statement),

    _statement: $ => choice(
      $.declaration,
      $.comment
    ),

    declaration: $ => prec.right('declaration', seq(
      optional('!'),
      $.constructor,
      repeat($.field_definition),
      '=',
      $.combinator,
      ';'
    )),

    constructor: $ => prec.left(seq(
      $.constructor_name,
      optional($.constructor_tag)
    )),

    constructor_name: $ => choice(
      '_',
      $.identifier
    ),

    constructor_tag: $ => choice(
      seq('$', choice('_', $._binary_number)),
      seq('#', choice('_', $._hex_number))
    ),

    field_definition: $ => prec.right('sequence', choice(
      $.field_parameter_def,
      $.field_curly_expr_def,
      $.field_named_def,
      $.field_anonymous_def,
      $.field_expr_def
    )),

    field_parameter_def: $ => seq(
      '{',
      repeat1(seq(
        $.identifier,
        ':',
        $.type_identifier
      )),
      '}'
    ),

    field_curly_expr_def: $ => seq(
      '{',
      $._expression,
      '}'
    ),

    field_named_def: $ => seq(
      $.identifier,
      ':',
      $._field_value
    ),

    _field_value: $ => choice(
      $.cell_ref_expression,
      $.conditional_expression,
      $._type_expression
    ),

    field_anonymous_def: $ => prec.right('sequence', seq(
      optional('^'),
      '[',
      repeat($.field_definition),
      ']'
    )),

    field_expr_def: $ => $._type_expression,

    combinator: $ => seq(
      $.identifier,
      prec.right('combinator_args', repeat($._type_expression))
    ),

    _expression: $ => choice(
      prec('comparison', $.comparison_expression),
      $.math_expression,
      $.conditional_expression,
      $.bit_selection_expression,
      prec('unary', $.negate_expression),
      $.parenthesized_expression,
      prec('primary', $._ref_expression)
    ),

    conditional_expression: $ => prec.right('conditional', seq(
      $._expression,
      '?',
      $._type_expression
    )),

    _type_expression: $ => choice(
      prec('application', $.type_application),
      $.cell_ref_expression,
      $.builtin_expression,
      $.type_math_expression,
      prec('unary', $.negate_expression),
      $.parenthesized_type_expression,
      prec('primary', $._ref_expression),
      '#'
    ),

    _type_expression_no_application: $ => choice(
      $.builtin_expression,
      $.type_math_expression,
      prec('unary', $.negate_expression),
      $.parenthesized_type_expression,
      prec('primary', $._ref_expression),
      '#'
    ),

    _type_app_argument: $ => choice(
      $._simple_type_expr,
      prec.right(1, $.cell_ref_expression),
      prec.right(1, $.negate_expression),
      prec.right(1, $.builtin_expression),
      $._number
    ),

    _simple_type_expr: $ => choice(
      $.identifier,
      'Any',
      $._number,
      $.parenthesized_type_expression
    ),

    math_expression: $ => prec.left('math', choice(
      seq($._expression, '+', $._expression),
      seq($._expression, '-', $._expression),
      seq($._expression, '*', $._expression),
      seq($._expression, '/', $._expression),
    )),

    type_math_expression: $ => prec.left('type_math', choice(
      seq($._type_expression, '+', $._type_expression),
      seq($._type_expression, '-', $._type_expression),
      seq($._type_expression, '*', $._type_expression),
      seq($._type_expression, '/', $._type_expression)
    )),

    comparison_expression: $ => prec.left('comparison', seq(
      $._expression,
      choice('<=', '>=', '!=', '=', '<', '>'),
      $._expression
    )),

    bit_selection_expression: $ => seq(
      $._expression,
      '.',
      $._number
    ),

    negate_expression: $ => prec.right('unary', seq(
      '~',
      choice(
        $._ref_expression,
        $.parenthesized_expression,
        $.parenthesized_type_expression
      )
    )),

    cell_ref_expression: $ => prec.right('cell_ref', seq(
      '^',
      choice(
        $.identifier,
        $.field_anonymous_def,
        $.parenthesized_type_application
      )
    )),

    type_application: $ => prec.right('application', seq(
      $.identifier,
      repeat1($._type_app_argument)
    )),

    parenthesized_type_application: $ => seq(
      '(',
      $.identifier,
      repeat1($._type_expression),
      ')'
    ),

    builtin_expression: $ => seq(
      '(',
      choice(
        seq($.builtin_operator, choice($._expression, $._number)),
        $.builtins_zero_args
      ),
      ')'
    ),

    builtin_operator: $ => choice(
      '##',
      '#<',
      '#<=',
      'lenBits'
    ),

    builtins_zero_args: $ => '#',

    _ref_expression: $ => prec('atom', choice(
      $.identifier,
      $._number
    )),

    parenthesized_expression: $ => seq(
      '(',
      $._expression,
      ')'
    ),

    parenthesized_type_expression: $ => seq(
      '(',
      $._type_expression,
      ')'
    ),

    comment: $ => token(choice(
      seq('//', /.*/),
      seq(
        '/*',
        /[^*]*\*+([^/*][^*]*\*+)*/,
        '/'
      )
    )),

    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    type_identifier: $ => choice(
      'Type',
      '#',
      $.identifier
    ),

    _number: $ => /\d+/,

    _hex_number: $ => /[a-fA-F0-9_]+/,

    _binary_number: $ => /[01_]+/
  }
});
