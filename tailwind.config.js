/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        display: ['"Cormorant Garamond"', "serif"],
        body: ['"Inter"', "sans-serif"],
      },
      colors: {
        ink: {
          50: "#f6f5f3",
          100: "#e8e6e1",
          200: "#d1ccc2",
          300: "#a8a092",
          400: "#7a7060",
          500: "#574e3f",
          600: "#3f372c",
          700: "#2b251d",
          800: "#1c1812",
          900: "#0f0d09",
        },
        gold: {
          50: "#fdfaf3",
          100: "#faf0dc",
          200: "#f4dfa8",
          300: "#ecca78",
          400: "#e3b54f",
          500: "#d29c34",
          600: "#b07c27",
          700: "#8a5e21",
          800: "#6e4a20",
          900: "#5c3e1f",
        },
        accent: {
          50: "#f0f6f5",
          100: "#d8ebe8",
          200: "#b3d7d2",
          300: "#84bcb5",
          400: "#549991",
          500: "#3a7c73",
          600: "#2d635c",
          700: "#27504a",
          800: "#22413c",
          900: "#1e3632",
        },
      },
      animation: {
        "fade-in": "fadeIn 0.5s ease-out",
        "slide-up": "slideUp 0.4s ease-out",
        "slide-in-right": "slideInRight 0.3s ease-out",
        "pulse-soft": "pulseSoft 2s ease-in-out infinite",
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: "0" },
          "100%": { opacity: "1" },
        },
        slideUp: {
          "0%": { opacity: "0", transform: "translateY(20px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        slideInRight: {
          "0%": { opacity: "0", transform: "translateX(30px)" },
          "100%": { opacity: "1", transform: "translateX(0)" },
        },
        pulseSoft: {
          "0%, 100%": { opacity: "1" },
          "50%": { opacity: "0.6" },
        },
      },
    },
  },
  plugins: [],
};
