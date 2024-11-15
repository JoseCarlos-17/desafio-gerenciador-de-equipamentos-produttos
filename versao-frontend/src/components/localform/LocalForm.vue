<template lang="">
  <div>
    <v-form id="local-form">
      <v-text-field
        class="form-item"
        v-model="local.name"
        label="Name"
        required></v-text-field>

        <div class="form-select">
        <select class="form-item" v-model="local.parent_id">
          <option class="placeholder" value="" disabled selected>
            Select your local option
          </option>
          <option v-for="localOption in localOptions"
                  :value="localOption.id" :key="localOption.id">
            {{localOption.name}}
          </option>
        </select>
      </div>
      <v-btn @click="createLocal()">Create Local</v-btn>
    </v-form>
  </div>
</template>

<script>
  import api_instance from '@/main';
  export default {
    data () {
      return {
        localOptions: [],
        local: {
          name: '',
          parent_id: ''
        }
      }
    },

    methods: {
      createLocal () {
        api_instance.post('/locations', { local: this.local })
                    .then(response => response)
      },

      loadLocationsOptions () {
        api_instance.get('/locations').then(response => {
          this.localOptions = response.data
        })
      }
    },

    mounted () {
      this.loadLocationsOptions()
    }
  }
</script>

<style>
    #local-form {
    margin: 20px 0px 20px 0px;
    display: flex;
    align-items: center;
    flex-direction: column;
  }

  #local-form > .form-item {
    width: 500px !important;
  }

  #local-form > .form-select > select {
    border-bottom: 1px solid rgba(128, 128, 128, 0.788);
    padding: 10px;
    color: rgba(0, 0, 0, 0.856);
    width: 500px !important;
    margin: 10px 0px 20px 0px;
    background-color: rgba(224, 224, 224, 0.473);
    opacity: 0.9;
  }

  #local-form > .form-select > .form-item > .placeholder {
    color: rgba(0, 0, 0, 0.856) !important;

  }
</style>