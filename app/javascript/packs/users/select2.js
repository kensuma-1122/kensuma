import 'select2';                       // globally assign select2 fn to $ element
import 'select2/dist/css/select2.css';  // optional if you have css loader

document.addEventListener("turbolinks:load", () => {
  $('.pref').select2({
    dropdownAutoWidth: true,
    width: 'auto'
  })
})