<template lang="">
  <div>
    <v-table id="equipment-table">
      <thead>
        <tr>
          <th v-for="tableLabel in tableLabels" :key="tableLabel.id">
            {{ tableLabel }}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="equipment in equipmentList" :key="equipment.id">
          <th>{{ equipment.name }}</th>
          <th>{{ equipment.brand }}</th>
          <th>{{ equipment.local }}</th>
          <th>{{ equipment.equipment_type }}</th>
          <th>{{ equipment.code }}</th>
          <th><img :src="equipment.equipment_photo" width="100"></th>
          <th>
            <div class="action-buttons">
              <v-btn class="button" color="primary" size="small"
                   @click="editFormRouter(equipment)">Edit</v-btn>
              <v-btn class="button" color="error" size="small"
                    @click="removeEquipment(equipment)">
                Remove
              </v-btn>
            </div>
          </th>
        </tr>
      </tbody>
    </v-table>
    <v-pagination
      v-model="page"
      :length="6"
    ></v-pagination>
  </div>
</template>

<script>
import api_instance from '@/main';

export default {
  data() {
      return {
        page: '',
        items: '',
        equipmentList: '',
        tableLabels: ['Name', 'Brand', 'Local', 'Type', 'Code', 'Photo', 'Actions']
      }
    },

    methods: {
      loadEquipment () {
        api_instance.get('/equipment').then((response) => {
          this.equipmentList = response.data
        })
      },

      removeEquipment (equipment) {
        api_instance.delete(`/equipment/${equipment.id}`).then(() => {
          this.$router.go(this.$router.currentRoute)
        })
      },

      editFormRouter (equipment) {
        this.$router.push(`/equipmentform/${equipment.id}`)
      }
    },

    mounted () {
      this.loadEquipment()
    }
}
</script>

<style>
  .action-buttons {
    display: flex;
    justify-content: space-evenly;
  }
</style>