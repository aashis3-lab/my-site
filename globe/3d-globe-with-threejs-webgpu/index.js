import * as THREE from "three";
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import getStarfield from "./src/getStarfield.js";
import { drawThreeGeo } from "./src/threeGeoJSON.js";
import { uniform, color, fog, rangeFogFactor } from "three/tsl";

const w = window.innerWidth;
const h = window.innerHeight;
const scene = new THREE.Scene();

scene.background = new THREE.Color(0x000000);
const camera = new THREE.PerspectiveCamera(75, w / h, 1, 100);
camera.position.z = 5;
const renderer = new THREE.WebGPURenderer({ antialias: true });
renderer.setSize(w, h);
document.body.appendChild(renderer.domElement);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;

const geometry = new THREE.SphereGeometry(2);
const lineMat = new THREE.LineBasicMaterial({ 
  color: 0x222222,
  // transparent: true,
  // opacity: 0.1, 
});
const edges = new THREE.EdgesGeometry(geometry, 1);
const line = new THREE.LineSegments(edges, lineMat);
scene.add(line);

const darkMat = new THREE.MeshBasicMaterial({ 
  color: 0x000000, 
  // side: THREE.BackSide,
  transparent: true,
  opacity: 0.99,
});
const darkGlobe = new THREE.Mesh(geometry, darkMat);
darkGlobe.scale.setScalar(0.99);
scene.add(darkGlobe);

const stars = getStarfield({ numStars: 1000, fog: false });
scene.add(stars);

// check here for more datasets ...
// https://github.com/martynafford/natural-earth-geojson
// non-geojson datasets: https://www.naturalearthdata.com/downloads/
fetch('./geojson/ne_110m_land.json')
  .then(response => response.text())
  .then(text => {
    const data = JSON.parse(text);
    const countries = drawThreeGeo({
      json: data,
      radius: 2,
      materialOptions: {
        color: 0x80FF80,
      },
    });
    scene.add(countries);
  });

function animate() {
  renderer.render(scene, camera);
  controls.update();
}
renderer.setAnimationLoop(animate);

function handleWindowResize () {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
}
window.addEventListener('resize', handleWindowResize, false);