<script setup>
import { format } from 'date-fns'

defineProps({
  title: String,
  summary: String,
  date: String,
  category: String
})
</script>

<template>
  <div class="bg-white shadow rounded-lg p-6 hover:shadow-lg transition-shadow duration-200">
    <div class="flex justify-between items-start mb-2">
      <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
        {{ category }}
      </span>
      <time class="text-sm text-gray-500">{{ format(new Date(date), 'yyyy年MM月dd日') }}</time>
    </div>
    <h2 class="text-xl font-semibold text-gray-900 mb-2">{{ title }}</h2>
    <p class="text-gray-600">{{ summary }}</p>
  </div>
</template>