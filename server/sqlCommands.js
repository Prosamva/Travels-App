// MySQL
module.exports = {

    towns: 
    `SELECT * FROM Town;`,
    
    register: 
    `INSERT IGNORE INTO Registrations VALUE (?, ?);`,

    addCustomer: 
    `INSERT INTO Customer VALUE(?, ?, ?, ?);`,

    customer: 
    `SELECT * FROM Customer WHERE face_id=?;`,

    updateCustomer: 
    `UPDATE Customer SET email=?, name=?, phone=? WHERE face_id=?;`,

    removeCustomer: 
    `DELETE FROM Customer WHERE face_id=?`,

    authorize: 
    `DELETE FROM Registrations WHERE face_id=? AND bus_id=?;`,

    removeRegistrations: 
    `DELETE FROM Registrations WHERE face_id=?;`,

    info:
    (clause) => 
    `SELECT 
        B.id AS bus_id,
        B.brand,
        B.chair_count,
        B.ac,
        SRC.name AS src_name,
        SRC.town_located AS src_town,
        DES.name AS des_name,
        DES.town_located AS des_town,
        BA.start_time,
        R.duration,
        R.distance,
    GROUP_CONCAT(DISTINCT D.name SEPARATOR ', ')         AS drivers,
    GROUP_CONCAT(DISTINCT IRT.inter_town SEPARATOR ', ') AS inter_towns
    FROM BusAllocation BA
        JOIN Bus B on B.id = BA.bus_id
        JOIN Route R on R.route_no = BA.route_no
        JOIN InterRouteTowns IRT on IRT.in_route_no = R.route_no
        JOIN Station SRC on R.start_point = SRC.station_id
        JOIN Station DES on R.end_point = DES.station_id
        JOIN DriverAllocation DA on B.id = DA.bus_id
        JOIN Driver D on DA.driver_id = D.id
    ${clause}
    GROUP BY BA.bus_id, BA.start_time
    ORDER BY BA.start_time;`
}