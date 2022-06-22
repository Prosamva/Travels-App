export function turnKeyed(data) {
  return data.map((item, i) => ({ key: i, value: item }));
}

// const ss = [
//     {
//       brand: "Eicher",
//       chair_count: 40,
//       src_name: "BTTC Standard Bus Stand",
//       src_town: "Visakhapatnam",
//       des_name: "General Bus Stop",
//       des_town: "Nagpur",
//       start_time: "07:30:00",
//       duration: "09:40:00",
//       distance: 316.39,
//       drivers: "Sanchit Srini",
//       inter_towns: "Kurnool",
//     },
//   ];
// export const sampleSlots = turnKeyed(ss);
export const defCities = [{ name: "ANY", key: 0 }];
export const serverUrl = "http://localhost:3001"; // "/api";
export const wildSelector = "ANY";