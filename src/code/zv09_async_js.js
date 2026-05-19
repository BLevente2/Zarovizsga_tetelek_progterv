function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function worker(name, ms) {
  console.log(`${name} indul`);
  await sleep(ms);
  console.log(`${name} kesz`);
  return name;
}

async function main() {
  const a = worker("A", 2000);
  const b = worker("B", 1000);
  const results = await Promise.all([a, b]);
  console.log(results);
}

main();
