<template>
  <footer
    v-if="$nav.currentLayout !== 'cover' && $nav.currentPage >= 2"
    class="absolute bottom-0 w-full py-2 px-8 flex flex-row justify-between text-neutral"
  >
  <div>
    Spack Tutorial for Beginners - NumPEx PC5
  </div>
  <div>
    {{ $nav.currentPage }} / {{ $nav.total }}
  </div>
  </footer>
</template>
