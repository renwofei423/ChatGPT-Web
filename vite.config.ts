import { defineConfig } from 'vite'
import { resolve } from 'path'
import react from '@vitejs/plugin-react-swc'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    // outDir: 'build/client'
    outDir: 'dist'
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, './src')
    }
  },
  css: {
    modules: {
      localsConvention: 'dashesOnly'
    },
    preprocessorOptions: {
      less: {
        modifyVars: {
          // hack: `true; @import (reference) "${resolve('src/styles/index.less')}";`,
        },
        javascriptEnabled: true
      }
    }
  },
  server: {
    host: '0.0.0.0',
    proxy: {
        '/api': {
            target: 'http://localhost:3200',
            changeOrigin: true
            // rewrite: (path) => path.replace(/^\/api/, '')
        }
    }
  }
})
