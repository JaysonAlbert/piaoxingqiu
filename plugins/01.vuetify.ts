import { createVuetify } from 'vuetify'
import { aliases, fa } from 'vuetify/iconsets/fa'
import { mdi } from 'vuetify/iconsets/mdi'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import { createPinia } from 'pinia'


export default defineNuxtPlugin(nuxtApp => {
  const vuetify = createVuetify({
    components,
    directives,
    icons: {
      defaultSet: 'mdi',
      aliases,
      sets: {
        fa,
        mdi
      }
    }
  })

  nuxtApp.vueApp.use(vuetify)

  const pinia = createPinia()
  nuxtApp.vueApp.use(pinia)
})