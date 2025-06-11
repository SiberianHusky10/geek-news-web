<!--
<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import NewsItem from "./components/NewsItem.vue";

const news = ref([])
const isMenuOpen = ref(false)
const isLanguageOpen = ref(false)
const selectedLanguage = ref('中文')
const languages = [
  { code: 'zh', name: '中文', flag: '🇨🇳' },
  { code: 'en', name: 'English', flag: '🇺🇸' },
  { code: 'ja', name: '日本語', flag: '🇯🇵' },
  { code: 'ko', name: '한국어', flag: '🇰🇷' },
  { code: 'fr', name: 'Français', flag: '🇫🇷' },
  { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
  { code: 'es', name: 'Español', flag: '🇪🇸' },
  { code: 'ru', name: 'Русский', flag: '🇷🇺' }
]

const selectLanguage = (language) => {
  selectedLanguage.value = language.name
  isLanguageOpen.value = false
  // 这里可以添加实际的语言切换逻辑
  console.log('Selected language:', language)
}

const toggleLanguageDropdown = () => {
  isLanguageOpen.value = !isLanguageOpen.value
}

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

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
      <div class="max-w-7xl mx-auto py-4 px-4">
        <div class="flex justify-between items-center">
          <h1 class="text-3xl font-bold text-gray-900">极刻快讯</h1>

          &lt;!&ndash; Mobile menu button &ndash;&gt;
          <div class="md:hidden">
            <button @click="toggleMenu" class="text-gray-500 hover:text-gray-700 focus:outline-none">
              <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path v-if="isMenuOpen" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>

          &lt;!&ndash; Desktop Navigation &ndash;&gt;
          <nav class="hidden md:flex items-center space-x-6">
            <a href="#about" class="text-gray-600 hover:text-gray-900">关于极刻快讯</a>

            &lt;!&ndash; Language Dropdown &ndash;&gt;
            <div class="relative">
              <button @click="toggleLanguageDropdown" class="flex items-center text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md">
                <span class="mr-1">🌐</span>
                {{ selectedLanguage }}
                <svg class="ml-1 h-4 w-4 transition-transform duration-200" :class="{ 'rotate-180': isLanguageOpen }" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              <div v-if="isLanguageOpen" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-20 border border-gray-200">
                <div class="px-3 py-2 text-xs text-gray-500 border-b border-gray-100">选择语言</div>
                <a v-for="lang in languages" :key="lang.code" href="#"
                   @click.prevent="selectLanguage(lang)"
                   class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 transition-colors duration-150"
                   :class="{ 'bg-blue-50 text-blue-700': selectedLanguage === lang.name }">
                  <span class="mr-3">{{ lang.flag }}</span>
                  {{ lang.name }}
                  <svg v-if="selectedLanguage === lang.name" class="ml-auto h-4 w-4 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                  </svg>
                </a>
              </div>
            </div>

            <a href="#sponsor" class="text-gray-600 hover:text-gray-900">网站赞助</a>
            <a href="#suggestions" class="text-gray-600 hover:text-gray-900">提出建议</a>
            <a href="https://admin.geeknews.tech" class="text-blue-500 hover:text-blue-700">登录</a>
          </nav>
        </div>

        &lt;!&ndash; Mobile Navigation &ndash;&gt;
        <div v-if="isMenuOpen" class="md:hidden mt-4 pb-2">
          <div class="flex flex-col space-y-3">
            <a href="#about" class="text-gray-600 hover:text-gray-900">关于极刻快讯</a>

            &lt;!&ndash; Mobile Language Selection &ndash;&gt;
            <div class="relative">
              <button @click="toggleLanguageDropdown" class="flex items-center text-gray-600 hover:text-gray-900 w-full text-left">
                <span class="mr-2">🌐</span>
                {{ selectedLanguage }}
                <svg class="ml-auto h-4 w-4 transition-transform duration-200" :class="{ 'rotate-180': isLanguageOpen }" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              <div v-if="isLanguageOpen" class="mt-2 ml-4 bg-gray-50 rounded-md py-2">
                <div class="px-3 py-1 text-xs text-gray-500">选择语言</div>
                <a v-for="lang in languages" :key="lang.code" href="#"
                   @click.prevent="selectLanguage(lang)"
                   class="flex items-center px-3 py-2 text-sm text-gray-700 hover:bg-gray-100 transition-colors duration-150"
                   :class="{ 'bg-blue-50 text-blue-700': selectedLanguage === lang.name }">
                  <span class="mr-3">{{ lang.flag }}</span>
                  {{ lang.name }}
                  <svg v-if="selectedLanguage === lang.name" class="ml-auto h-4 w-4 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                  </svg>
                </a>
              </div>
            </div>

            <a href="#sponsor" class="text-gray-600 hover:text-gray-900">网站赞助</a>
            <a href="#suggestions" class="text-gray-600 hover:text-gray-900">提出建议</a>
            <a href="https://admin.geeknews.tech" class="text-blue-500 hover:text-blue-700">登录</a>
          </div>
        </div>
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
-->

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import NewsItem from "./components/NewsItem.vue";

const news = ref([])
const isMenuOpen = ref(false)
const isLanguageOpen = ref(false)
const selectedLanguage = ref('中文')
const languages = [
  { code: 'zh', name: '中文', flag: '🇨🇳' },
  { code: 'en', name: 'English', flag: '🇺🇸' },
  { code: 'ja', name: '日本語', flag: '🇯🇵' },
  { code: 'ko', name: '한국어', flag: '🇰🇷' },
  { code: 'fr', name: 'Français', flag: '🇫🇷' },
  { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
  { code: 'es', name: 'Español', flag: '🇪🇸' },
  { code: 'ru', name: 'Русский', flag: '🇷🇺' }
]

const selectLanguage = (language) => {
  selectedLanguage.value = language.name
  isLanguageOpen.value = false
  // 这里可以添加实际的语言切换逻辑
  console.log('Selected language:', language)
}

const toggleLanguageDropdown = () => {
  isLanguageOpen.value = !isLanguageOpen.value
}

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

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
      <div class="max-w-7xl mx-auto py-4 px-4">
        <div class="flex justify-between items-center">
          <h1 class="text-3xl font-bold text-gray-900">极刻快讯</h1>

          <!-- Mobile menu button -->
          <div class="md:hidden">
            <button @click="toggleMenu" class="text-gray-500 hover:text-gray-700 focus:outline-none">
              <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path v-if="isMenuOpen" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>

          <!-- Desktop Navigation -->
          <nav class="hidden md:flex items-center space-x-6">
            <a href="#about" class="text-gray-600 hover:text-gray-900">关于极刻快讯</a>

            <!-- Language Dropdown -->
            <div class="relative">
              <button @click="toggleLanguageDropdown" class="flex items-center text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md">
                <span class="mr-1">🌐</span>
                {{ selectedLanguage }}
                <svg class="ml-1 h-4 w-4 transition-transform duration-200" :class="{ 'rotate-180': isLanguageOpen }" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              <div v-if="isLanguageOpen" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-20 border border-gray-200">
                <div class="px-3 py-2 text-xs text-gray-500 border-b border-gray-100">选择语言</div>
                <a v-for="lang in languages" :key="lang.code" href="#"
                   @click.prevent="selectLanguage(lang)"
                   class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 transition-colors duration-150"
                   :class="{ 'bg-blue-50 text-blue-700': selectedLanguage === lang.name }">
                  <span class="mr-3">{{ lang.flag }}</span>
                  {{ lang.name }}
                  <svg v-if="selectedLanguage === lang.name" class="ml-auto h-4 w-4 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                  </svg>
                </a>
              </div>
            </div>

            <a href="#sponsor" class="text-gray-600 hover:text-gray-900">网站赞助</a>
            <a href="#suggestions" class="text-gray-600 hover:text-gray-900">提出建议</a>
            <a href="https://admin.geeknews.tech"
               class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-full font-medium transition-colors duration-200 shadow-md hover:shadow-lg">
              登录
            </a>
          </nav>
        </div>

        <!-- Mobile Navigation -->
        <div v-if="isMenuOpen" class="md:hidden mt-4 pb-2">
          <div class="flex flex-col space-y-3">
            <a href="#about" class="text-gray-600 hover:text-gray-900">关于极刻快讯</a>

            <!-- Mobile Language Selection -->
            <div class="relative">
              <button @click="toggleLanguageDropdown" class="flex items-center text-gray-600 hover:text-gray-900 w-full text-left">
                <span class="mr-2">🌐</span>
                {{ selectedLanguage }}
                <svg class="ml-auto h-4 w-4 transition-transform duration-200" :class="{ 'rotate-180': isLanguageOpen }" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              <div v-if="isLanguageOpen" class="mt-2 ml-4 bg-gray-50 rounded-md py-2">
                <div class="px-3 py-1 text-xs text-gray-500">选择语言</div>
                <a v-for="lang in languages" :key="lang.code" href="#"
                   @click.prevent="selectLanguage(lang)"
                   class="flex items-center px-3 py-2 text-sm text-gray-700 hover:bg-gray-100 transition-colors duration-150"
                   :class="{ 'bg-blue-50 text-blue-700': selectedLanguage === lang.name }">
                  <span class="mr-3">{{ lang.flag }}</span>
                  {{ lang.name }}
                  <svg v-if="selectedLanguage === lang.name" class="ml-auto h-4 w-4 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                  </svg>
                </a>
              </div>
            </div>

            <a href="#sponsor" class="text-gray-600 hover:text-gray-900">网站赞助</a>
            <a href="#suggestions" class="text-gray-600 hover:text-gray-900">提出建议</a>
            <a href="https://admin.geeknews.tech"
               class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-full font-medium transition-colors duration-200 shadow-md hover:shadow-lg text-center">
              登录
            </a>
          </div>
        </div>
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
