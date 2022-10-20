import './CitySelector.css'

export default function CitySelector({ id, label, cities, value, onChanged }) {
    return (
        <div className="csc">
            <label htmlFor={id}>{label}</label>
            <div className="select-container">
            <select onChange={onChanged} id={id} value={value}>
                {cities.map(city =>
                <option key={city.key}>{city.name}</option>
                )}
            </select>
            </div>
        </div>
    );
}