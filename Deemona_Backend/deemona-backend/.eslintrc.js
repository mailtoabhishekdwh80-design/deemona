// .eslintrc.js
module.exports = {
  env:     { node: true, es2022: true, jest: true },
  extends: ['eslint:recommended'],
  parserOptions: { ecmaVersion: 2022 },
  rules: {
    // Errors
    'no-unused-vars':       ['error', { argsIgnorePattern: '^_', varsIgnorePattern: '^_' }],
    'no-undef':             'error',
    'no-console':           'off',     // server-side logging is fine
    'no-process-exit':      'warn',

    // Style (non-blocking)
    'prefer-const':         'warn',
    'no-var':               'warn',
    'eqeqeq':               ['warn', 'always', { null: 'ignore' }],
    'curly':                ['warn', 'multi-line'],
    'no-throw-literal':     'error',

    // Async safety
    'no-async-promise-executor': 'error',
    'require-await':             'warn',
    'no-return-await':           'warn',
  },
  ignorePatterns: ['node_modules/', 'coverage/', 'public/'],
};
