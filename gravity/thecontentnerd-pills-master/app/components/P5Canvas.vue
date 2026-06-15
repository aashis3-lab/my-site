<template>
  <!-- prettier-ignore -->
  <div class="p5canvas">
    <Pill text="copywriter" bg="#CCFFFC" color="#00322F" :x="181" :y="199" :deg="-5.63" :width="116" />
    <Pill text="writer & editor" bg="#F6DBD4" color="#250B04" :x="295" :y="425" :deg="-5.63" :width="145" />
    <Pill text="SEO specialist" bg="#F6DBD4" color="#250B04" :x="1112" :y="471" :deg="10.047" :width="156" />
    <Pill text="product marketer" bg="#FEEACD" color="#191105" :x="514" :y="509" :deg="-7.52" :width="185" />
    <Pill text="email marketer" bg="#FEEACD" color="#191105" :x="1273" :y="282" :deg="7.518" :width="159" />
    <Pill text="content strategist" bg="#D4CCFF" color="#090424" :x="521" :y="299" :deg="5.885" :width="189" />
    <Pill text="storyteller" bg="#CCFFFC" color="#00322F" :x="1409" :y="477" :deg="-5.633" :width="107" />
    <Pill text="producer" bg="#D4CCFF" color="#090424" :x="954" :y="178" :deg="-8.87" :width="99" />
    <Pill text="director" bg="#FEEACD" color="#191105" :x="747" :y="230" :deg="-5.63" :width="82" />
    <Pill text="copywriter" bg="#CCFFFC" color="#00322F" :x="181" :y="199" :deg="-5.63" :width="116" />
    <Pill text="writer & editor" bg="#F6DBD4" color="#250B04" :x="295" :y="425" :deg="-5.63" :width="145" />
    <Pill text="SEO specialist" bg="#F6DBD4" color="#250B04" :x="1112" :y="471" :deg="10.047" :width="156" />
    <Pill text="product marketer" bg="#FEEACD" color="#191105" :x="514" :y="509" :deg="-7.52" :width="185" />
    <Pill text="email marketer" bg="#FEEACD" color="#191105" :x="1273" :y="282" :deg="7.518" :width="159" />
    <Pill text="content strategist" bg="#D4CCFF" color="#090424" :x="521" :y="299" :deg="5.885" :width="189" />
    <Pill text="storyteller" bg="#CCFFFC" color="#00322F" :x="1409" :y="477" :deg="-5.633" :width="107" />
    <Pill text="producer" bg="#D4CCFF" color="#090424" :x="954" :y="178" :deg="-8.87" :width="99" />
    <Pill text="director" bg="#FEEACD" color="#191105" :x="747" :y="230" :deg="-5.63" :width="82" />
    <Pill text="copywriter" bg="#CCFFFC" color="#00322F" :x="181" :y="199" :deg="-5.63" :width="116" />
    <Pill text="writer & editor" bg="#F6DBD4" color="#250B04" :x="295" :y="425" :deg="-5.63" :width="145" />
    <Pill text="SEO specialist" bg="#F6DBD4" color="#250B04" :x="1112" :y="471" :deg="10.047" :width="156" />
    <Pill text="product marketer" bg="#FEEACD" color="#191105" :x="514" :y="509" :deg="-7.52" :width="185" />
    <Pill text="email marketer" bg="#FEEACD" color="#191105" :x="1273" :y="282" :deg="7.518" :width="159" />
    <Pill text="content strategist" bg="#D4CCFF" color="#090424" :x="521" :y="299" :deg="5.885" :width="189" />
    <Pill text="storyteller" bg="#CCFFFC" color="#00322F" :x="1409" :y="477" :deg="-5.633" :width="107" />
    <Pill text="producer" bg="#D4CCFF" color="#090424" :x="954" :y="178" :deg="-8.87" :width="99" />
    <Pill text="director" bg="#FEEACD" color="#191105" :x="747" :y="230" :deg="-5.63" :width="82" />
  </div>
</template>

<script setup lang="ts">
import type p5 from "p5";
type Pill = {
  text: string;
  bg: string;
  color: string;
  x: number;
  y: number;
  deg: number;
  width: number;
};

onMounted(async () => {
  const Matter = await import("matter-js");
  const { default: p5 } = await import("p5");

  const pillElements = document.querySelectorAll<HTMLElement>(".p5canvas p");
  const pills: Pill[] = Array.from(pillElements).map((pill) => {
    const attribute = pill.getAttribute("data-props");
    return JSON.parse(attribute || "{}");
  });

  let objects: ColoredPill[] = [];

  const engine = Matter.Engine.create();
  const world = engine.world;
  const composite = Matter.Composite;

  class ColoredPill {
    body: Matter.Body;
    pill: Pill;
    constructor(pill: Pill) {
      this.body = Matter.Bodies.rectangle(pill.x, pill.y, pill.width + 32, 42);
      this.pill = pill;
      composite.add(world, this.body);
    }
    update(p5: p5) {
      const position = this.body.position;
      const angle = this.body.angle || this.pill.deg;
      p5.angleMode(this.body.angle ? "radians" : "degrees");
      p5.push();
      p5.translate(position.x, position.y);
      p5.rotate(angle);
      p5.rectMode("center");
      p5.fill(this.pill.bg);
      p5.rect(0, 0, this.pill.width + 32, 42, 70);

      p5.fill(this.pill.color);
      p5.textSize(24);
      p5.textWeight(500);
      p5.textAlign("center", "center");
      p5.text(this.pill.text, 0, 0);
      p5.pop();
    }
  }

  function init(p5: p5) {
    p5.setup = () => {
      p5.createCanvas(1520, 600);
      objects = pills.map((pill) => new ColoredPill(pill));

      const ceiling = Matter.Bodies.rectangle(p5.width / 2, 50, p5.width, 10, {
        isStatic: true,
      });
      const ground = Matter.Bodies.rectangle(
        p5.width / 2,
        p5.height - 50,
        p5.width,
        10,
        { isStatic: true },
      );
      const wallLeft = Matter.Bodies.rectangle(
        50,
        p5.height / 2,
        10,
        p5.height,
        { isStatic: true },
      );
      const wallRight = Matter.Bodies.rectangle(
        p5.width - 50,
        p5.height / 2,
        10,
        p5.height,
        { isStatic: true },
      );
      composite.add(world, [ceiling, ground, wallLeft, wallRight]);
    };

    p5.draw = () => {
      p5.clear();
      objects.forEach((object) => {
        object.update(p5);
      });
      Matter.Engine.update(engine);
    };

    p5.mouseDragged = () => {
      for (let pill of objects) {
        if (
          p5.dist(
            p5.mouseX,
            p5.mouseY,
            pill.body.position.x,
            pill.body.position.y,
          ) < 50
        ) {
          Matter.Body.applyForce(
            pill.body,
            {
              x: pill.body.position.x,
              y: pill.body.position.y,
            },
            {
              x: p5.random(-0.15, 0.15),
              y: p5.random(-0.1, 0),
            },
          );
        }
      }
    };
  }

  const $p5 = new p5(init, document.querySelector<HTMLElement>(".p5canvas")!);
});
</script>
