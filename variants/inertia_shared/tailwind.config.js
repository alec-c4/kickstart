/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './app/frontend/**/*.{js,jsx,ts,tsx,vue,svelte}',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  darkMode: 'class',
  theme: {
    extend: {},
  },
  plugins: [],
};
