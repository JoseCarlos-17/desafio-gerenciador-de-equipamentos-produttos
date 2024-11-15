<template lang="html">
  <div>
    <ul id="menu-list">
      <li class="menu-item">
        <v-btn class="menu-button"><router-link to="/"><a style="color">Equipment List</a></router-link></v-btn>
      </li>
      <li class="menu-item">
        <v-btn class="menu-button"><router-link to="/equipmentform"><a>Create Equipment</a></router-link></v-btn>
      </li>
      <li class="menu-item">
        <v-btn class="menu-button"><router-link to="/localform"><a>Create local</a></router-link></v-btn>
      </li>
    </ul>
    <v-row>
      <v-col>
        <router-view></router-view>
      </v-col>
    </v-row>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
  }
}
</script>

<style lang="css">
  #app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }

  #menu-list {
    display: flex;
    flex-direction: row;
    color: white;
    margin: 70px 600px 30px 600px !important;
    justify-content: space-evenly;
  }

  #menu-list > .menu-item > .menu-button {
    background-color: rgba(211, 211, 211, 0.575);
  }

  #menu-list > .menu-item > .menu-button > a {
    color: white !important;
  }
</style>
