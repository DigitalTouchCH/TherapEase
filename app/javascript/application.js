// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
// Add Bootstrap JavaScript
require('bootstrap/dist/js/bootstrap')

// Add chartkick
import { Chart, PieController, ArcElement } from 'chart.js';
Chart.register(PieController, ArcElement);
import Chartkick from 'chartkick';
window.Chartkick = Chartkick;
Chartkick.addAdapter(Chart);
