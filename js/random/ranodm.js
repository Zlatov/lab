var rand, min, max

min = 10
max = 11
// floor - округляет в меньшую сторону 1.9 в 1, -1.9 в -2
rand = min + Math.floor((max - min + 1) * Math.random());

console.log('rand: ', rand)
