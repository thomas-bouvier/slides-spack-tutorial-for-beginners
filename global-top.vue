<template>
  <footer
    v-if="$nav.currentLayout !== 'cover' && $nav.currentPage >= 2"
    class="absolute bottom-0 w-full py-2 px-8 flex flex-row justify-between text-neutral"
  >
  <div class="flex flex-row items-center gap-4">
    <img src="./Logo_France_2030.svg" width="30" class="bg-white rounded-full">
    Spack Tutorial for Beginners - NumPEx PC5
  </div>
  <div>
    {{ $nav.currentPage }} / {{ $nav.total }}
  </div>
  </footer>
</template>
