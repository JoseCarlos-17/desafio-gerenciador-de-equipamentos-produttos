import { createRouter, createWebHashHistory } from 'vue-router'

import Equipmentlist from '../screens/equipmentlist/EquipmentList.vue'
import EquipmentForm from '../screens/equipmentform/EquipmentForm.vue'
import LocalForm from '../screens/localform/LocalForm.vue'

const routes = [
  { path: '/', name: 'EquipmentList', component: Equipmentlist },
  { path: '/equipmentform', name: 'EquipmentForm', component: EquipmentForm },
  { path: '/localform', name: 'LocalForm', component: LocalForm },
  { path: '/equipmentform/:id', name: 'EditEquipmentForm', component: EquipmentForm }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router