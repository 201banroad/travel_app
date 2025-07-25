// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

// import Rails from "@rails/ujs"
// Rails.start()

import "@hotwired/turbo-rails"
import "controllers"


// const container = document.querySelector('.sticky-container');
// const notes = document.querySelectorAll('.sticky-note');

// notes.forEach((note, i) => {
//   const containerWidth = container.clientWidth;
//   const containerHeight = container.clientHeight;

//   const noteWidth = 170;
//   const noteHeight = 150;

//   const maxLeft = containerWidth - noteWidth;
//   const maxTop = containerHeight - noteHeight;

//   const randomLeft = Math.random() * maxLeft;
//   const randomTop = Math.random() * maxTop;

//   note.style.left = `${randomLeft}px`;
//   note.style.top = `${randomTop}px`;

//   note.style.transform = `rotate(${(Math.random() - 0.5) * 10}deg)`; // -5〜+5度の傾き
// });
