<template lang="">
  <div>
    <v-form id="equipment-form">
      <v-text-field class="form-item"
                    v-model="equipment.name" label="Name">
      </v-text-field>

      <v-text-field class="form-item"
                    v-model="equipment.brand" label="Brand">
      </v-text-field>

      <v-text-field class="form-item"
                    v-model="equipment.code" label="Code">
      </v-text-field>

      <v-select class="form-item"
        v-model="equipment.equipment_type"
        :items="equipmentOptions" item-text="key"
        item-value="id" label="Type"></v-select>

        <v-file-input
          class="form-item"
          @change="handleFileUpload( $event )"
            label="Photo"
            id="file" ref="file"
          ></v-file-input>
    
      <v-text-field class="form-item"
                    v-model="equipment.note" label="Note">
      </v-text-field>
      
      <div class="form-select">
        <select class="form-item" v-model="equipment.local_id">
          <option class="placeholder" value="" disabled selected>
            Select your local option
          </option>
          <option v-for="localOption in localOptions"
                  :value="localOption.id" :key="localOption.id">
            {{localOption.name}}
          </option>
        </select>
      </div>

      <v-btn @click="this.$route.params.id ? editEquipment() : createEquipment()">
        {{ changeButtonName }}
      </v-btn>
    </v-form>
  </div>
</template>
<script>
  import api_instance from '@/main';

export default {
  data() {
      return {
        equipmentOptions: [],
        localOptions: [],
        equipment: {
          name: '',
          brand: '',
          equipment_type: '',
          equipment_photo: '',
          code: '',
          note: '',
          local_id: '' 
        }
      }
    },

  methods: {
      loadEquipmentOptions () {
        api_instance.get('/equipment/equipment_type_options')
                    .then(response => {
          this.equipmentOptions = response.data.map(item => item.key)
        })
      },

      loadLocationsOptions () {
        api_instance.get('/locations').then(response => {
          this.localOptions = response.data
        })
      },

      createEquipment () {
        api_instance.post('/equipment', { equipment: this.equipment }, {
          headers: {
              'Content-Type': 'multipart/form-data'
          }
        }).then(() => this.$router.push('/'))
      },

      loadEditForm () {
        let headers = { headers: { 'Content-Type': 'multipart/form-data' } }

        if (this.$route.params.id) {
          api_instance.get(`/equipment/${this.$route.params.id}`, headers).then(response => {              
              this.equipment = {
                name: response.data.name,
                brand: response.data.brand,
                equipment_type: response.data.equipment_type,
                equipment_photo: response.data.equipment_photo,
                code: response.data.code,
                note: response.data.note,
                local_id: response.data.local.id
              }
            }) } else {
              this.equipment = {
                name: '',
                brand: '',
                equipment_type: '',
                equipment_photo: '',
                code: '',
                note: '',
                local_id: '' 
              }
            }
      },

      handleFileUpload(){
        this.equipment.equipment_photo = this.$refs.file.files[0]
      },

      editEquipment () {
        api_instance.put(`/equipment/${this.$route.params.id}`, { equipment: this.equipment })
                    .then(() => this.$router.push('/'))
      }
    },

    computed: {
      changeButtonName () {
        return this.$route.params.id ? 'Edit Equipment' : 'Create Equipment'
      }
    },

    mounted () {
      this.loadEquipmentOptions()
      this.loadLocationsOptions()
      this.loadEditForm()
    }
}
</script>
<style>
  #equipment-form {
    margin: 20px 0px 20px 0px;
    display: flex;
    align-items: center;
    flex-direction: column;
  }

  #equipment-form > .form-item {
    width: 500px !important;
  }

  #equipment-form > .form-select > select {
    border-bottom: 1px solid rgba(128, 128, 128, 0.788);
    padding: 10px;
    color: rgba(0, 0, 0, 0.856);
    width: 500px !important;
    margin: 10px 0px 20px 0px;
    background-color: rgba(224, 224, 224, 0.473);
    opacity: 0.9;
  }

  #equipment-form > .form-select > .form-item > .placeholder {
    color: rgba(0, 0, 0, 0.856) !important;

  }
</style>