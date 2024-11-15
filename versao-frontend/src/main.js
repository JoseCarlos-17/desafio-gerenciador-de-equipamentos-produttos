import { createApp } from 'vue'
import App from './App.vue'
import router from './routes/index'
import axios from 'axios'

import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'

const vuetify = createVuetify({
  components,
  directives,
})

const api_instance = axios.create({
    baseURL: "http://localhost:3000"
})

export default api_instance

createApp(App)
.use(router)
.use(vuetify)
.mount('#app')
