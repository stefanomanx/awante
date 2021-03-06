import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkerToMap()
    this.#fitMapToMarker()
  }

  #addMarkerToMap() {
    new mapboxgl.Marker()
    .setLngLat([this.markerValue[1], this.markerValue[0]])
    .addTo(this.map);
  }

  #fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend([ this.markerValue[1], this.markerValue[0] ])
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 17, duration: 0 })
  }

}
