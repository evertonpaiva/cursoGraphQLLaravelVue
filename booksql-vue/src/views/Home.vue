<template>
  <div class="home">
    <ApolloQuery :query="require('@/graphql/queries/Categories.graphql')">
      <template slot-scope="{ result: { data, loading } }">
        <div v-if="loading">Loading...</div>
        <ul v-else>
          <li v-for="category of data.categories" :key="category.id" class="user">
            {{ category.id }} {{ category.name }}
          </li>
        </ul>
      </template>
    </ApolloQuery>
  </div>
</template>

<script>
// @ is an alias to /src
import gql from 'graphql-tag'

export default {
  name: 'home',
  components: {

  },
  data() {
    return {
        categories: []
    }
  },
  apollo: {
      categories: gql`{
        categories {
            id
            name
        }
      }`,
  },
}
</script>
