/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./layouts/**/*.html"],
  theme: {
    extend: {
      colors: {
        'main': '#8C6056',
        'secondary': '#AFD5AA',
        'body-text': '#3d3d3d',
        'heading-text': '#383838',
        'background': '#fff'
      },
      maxWidth: {
        'content': '650px',
      },
      typography: {
        DEFAULT: {
          css: {
            a: {
              color: 'inherit',
              textDecoration: 'none',
              borderBottom: '1px solid rgba(0,0,0,0.4)',
              '&:hover': {
                borderBottom: '1px solid #3d3d3d',
                color: '#3d3d3d',
              },
            },
            h1: { color: '#8C6056' },
            h2: { color: '#8C6056' },
            h3: { color: '#8C6056' },
            h4: { color: '#8C6056' },
            h5: { color: '#8C6056' },
            h6: { color: '#8C6056' },
            pre: {
              fontSize: '0.9em',
              padding: '10px 20px',
              lineHeight: '1.25em',
            },
            'p code': {
              padding: '0.25rem 0.5rem',
              fontSize: '0.9em',
              backgroundColor: '#f8f8f8',
            },
            blockquote: {
              borderLeftColor: '#AFD5AA',
              borderLeftWidth: '0.25rem',
              color: '#666',
              fontStyle: 'italic',
            },
            table: {
              fontSize: '14px',
              margin: '2rem auto',
            },
            'tr:nth-child(2n)': {
              backgroundColor: '#f8f8f8',
            },
          }
        }
      }
    },
    fontFamily: {
      'sans': ['"Source Sans Pro"', 'sans-serif'],
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}