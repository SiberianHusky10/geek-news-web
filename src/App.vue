<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import NewsItem from "./components/NewsItem.vue";

const news = ref([])

onMounted(async () => {
  try {
    const response = await axios.get('https://api.geeknews.tech/article?pageNum=1&pageSize=20')
    news.value = response.data.data.items
    console.log(news.value)
  } catch (error) {
    console.error('Failed to fetch news articles:', error)
  }
})
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div class="max-w-7xl mx-auto py-6 px-4 flex justify-between items-center">
        <h1 class="text-3xl font-bold text-gray-900">极刻快讯</h1>
        <a href="https://admin.geeknews.tech" class="text-blue-500 hover:text-blue-700 text-lg">登录</a>
      </div>
    </header>

    <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      <div class="px-4 py-6 sm:px-0">
        <div class="flex flex-col gap-4">
          <NewsItem
            v-for="article in news"
            :key="article.id"
            :title="article.title"
            :summary="article.content"
            :date="article.createTime"
            :category="article.category"
          />
        </div>
      </div>
    </main>
  </div>
</template>