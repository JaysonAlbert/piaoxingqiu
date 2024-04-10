// https://nuxt.com/docs/api/configuration/nuxt-config

import vuetify from 'vite-plugin-vuetify'
import { createResolver } from '@nuxt/kit'

const { resolve } = createResolver(import.meta.url)

export default defineNuxtConfig({
  modules: [
    '@invictus.codes/nuxt-vuetify',
    '@vee-validate/nuxt',
    '@sidebase/nuxt-auth',
  ],

  runtimeConfig: {
    apiSecret: '123',
  },

  css: [
    'vuetify/lib/styles/main.sass',
    '@mdi/font/css/materialdesignicons.min.css',
    '~/assets/css/main.css'
  ],

  ssr: false,

  build: {
    transpile: ['vuetify'],
  },

  vite: {
    ssr: {
      noExternal: ['vuetify'],
    },
    define: {
      'process.env.DEBUG': false,
    },
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `@use './assets/styles/settings.scss' as *;`,
        },
      },
    },
  },

  sourcemap: {
    server: false,
    client: false,
  },

  devtools: { enabled: true },

  hooks: {
    'vite:extendConfig': (config) => {
      config.plugins.push(
        vuetify({
          styles: { configFile: resolve('assets/styles/settings.scss') },
        })
      )
    },
  },

  auth: {
    globalAppMiddleware: true,
    provider: {
      type: 'local',
      token: {
        signInResponseTokenPointer: '/data/accessToken'
      },
    }
  },

  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
})
