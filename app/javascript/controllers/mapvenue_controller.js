import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Array
  }

  connect() {

    console.log(this.markerValue[0])

    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    new mapboxgl.Marker()
    .setLngLat([markerValue[0], markerValue[1]])
    .addTo(this.map);
    this.#fitMapToMarker()

  }



  #fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markerValue(bounds.extend([ marker[0], marker[1] ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
