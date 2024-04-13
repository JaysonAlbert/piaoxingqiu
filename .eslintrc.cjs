/* eslint-env node */
module.exports = {
    extends: [
        'eslint:recommended',
        'plugin:@typescript-eslint/recommended',
        'plugin:@typescript-eslint/recommended-requiring-type-checking',
        '@nuxtjs/eslint-config-typescript',
        'plugin:nuxt/recommended',
    ],
    parser: '@typescript-eslint/parser',
    plugins: ['@typescript-eslint', 'nuxt'],
    parserOptions: {
        project: true,
        tsconfigRootDir: __dirname,
    },
    root: true,
};