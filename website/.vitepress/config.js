import { defineConfig } from 'vitepress'
import { withMermaid } from 'vitepress-plugin-mermaid'

export default withMermaid(defineConfig({
  title: 'sznm_dart_packages',
  description: "agustinusnathaniel's personal Dart/Flutter packages",

  lastUpdated: true,
  cleanUrls: true,
  ignoreDeadLinks: true,

  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['meta', { name: 'theme-color', content: '#5f67bc' }],
  ],

  themeConfig: {
    logo: {
      src: '/logo.png',
      alt: 'sznm_dart_packages',
    },

    siteTitle: 'sznm_dart_packages',

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Packages', link: '/packages/sznm_lints/' },
      { text: 'Guide', link: '/guide/getting-started' },
    ],

    sidebar: {
      '/packages/': [
        {
          text: 'sznm_lints',
          items: [
            { text: 'Overview', link: '/packages/sznm_lints/' },
            { text: 'Usage', link: '/packages/sznm_lints/usage' },
            { text: 'Rules', link: '/packages/sznm_lints/rules' },
          ],
        },
      ],
      '/guide/': [
        {
          text: 'Guide',
          items: [
            { text: 'Getting Started', link: '/guide/getting-started' },
            { text: 'Development', link: '/guide/development' },
            { text: 'Releasing', link: '/guide/releasing' },
          ],
        },
      ],
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/agustinusnathaniel/sznm_dart_packages' },
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2022-present agustinusnathaniel',
    },

    search: {
      provider: 'local',
    },
  },

  markdown: {
    lineNumbers: true,
  },

  vite: {
    optimizeDeps: {
      include: ['mermaid'],
    },
  },
}))
