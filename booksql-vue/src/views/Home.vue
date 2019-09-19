<template>
  <div class="home">
    <ApolloQuery :query="require('@/graphql/queries/Categories.graphql')">
      <template slot-scope="{ result: { data, loading }, isLoading  }">
        <div v-if="isLoading">Loading...</div>
        <div v-else>
          <a href="#" v-for="category of data.categories" :key="category.id"
             @click="selectCategory(category.id)" class="link-margin">
            {{ category.id }}. {{ category.name }}
          </a>
        </div>
      </template>
    </ApolloQuery>

    <!--<ApolloQuery :query="require('@/graphql/queries/Books.graphql')">
      <template slot-scope="{ result: { data, loading }, isLoading  }">
        <div v-if="isLoading">Loading...</div>
        <div v-else>
          <div href="#" v-for="book of data.books" :key="book.id" class="link-margin">
            {{ book.id }}. {{ book.title }}
          </div>
        </div>
      </template>
    </ApolloQuery>-->

    <ApolloQuery :query="require('@/graphql/queries/Category.graphql')" :variables="{ id: selectedCategory }">
      <template slot-scope="{ result: { data, loading }, isLoading  }">
        <div v-if="isLoading">Loading...</div>
        <div v-else>
          <div href="#" v-for="book of data.category.books" :key="book.id" class="link-margin">
            {{ book.id }}. {{ book.title }}
          </div>
        </div>
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
        selectedCategory: 1,
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
  methods: {
      selectCategory(category) {
          this.selectedCategory = category
      }
  }
}
</script>

<style>
  .link-margin {
    margin-right: 24px;
  }
</style>
