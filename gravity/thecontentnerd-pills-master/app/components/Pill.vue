<template>
  <p :data-props="JSON.stringify(props)">{{ props.text }}</p>
</template>

<script setup lang="ts">
const props = defineProps<{
  text: string;
  bg: string;
  color: string;
  x: number;
  y: number;
  deg: number;
  width: number;
}>();
</script>
