import React, { Component } from 'react';


class About extends Component {

  render() {
    const events = [{
      title: "Shooting",
      rating:"0.8",
      notes:"Someone is firing a gun at someone else."
    },{
      title: "Shots Fired",
      rating:"0.5",
      notes:"Someone heard or saw gunfire."
    },{
      title: "Shots Fired - Into Dwelling",
      rating:"0.7",
      notes:"Someone reported gunfire directed at a home."
    },{
      title: "Shots Fired - Property Damage",
      rating:"0.7",
      notes:"Someone reported gunfire at non-residential property."
    },{
      title: "New Year's Eve - Shots Fired",
      rating:"0.7",
      notes:"Someone reported gunfire on this gunshots-heavy holiday."
    },{
      title: "Shot Spotter",
      rating:"0.9",
      notes: (<span><a href="http://www.shotspotter.com/">A shotspotter detected gunfire</a>, and let the police know.</span>)
    },{
      title: "Fireworks",
      rating:"0.8",
      notes: "Someone heard, or saw fireworks."
    },{
      title: "Fireworks - Fourth of July",
      rating:"0.5",
      notes: "Someone heard fireworks on this fireworks-heavy holiday."
    }]

    return (
      <main className="About">
        <h1>About</h1>
        <p>
          St. Louis is <a href="http://www.slmpd.org/crimestats/CRM0013-BY_201703.pdf" target="_blank">no stranger to gun crime</a>. In 2017, 508 people had either been shot (or shot at) by April.</p>
        <p>It's also a city with a <a href="https://explorestlouis.com/events/list/?tribe_paged=1&tribe_event_display=list&tribe_eventcategory=1018">huge number of festivals and events all year round</a>, and a ravenous love for baseball. If you live near a park, or Bush Stadium, then firework displays can be fairly routine.
        </p>
        <p>
          Which means, if you're like me, that sometimes you'll hear a bang off in the distance and wonder, "...Gunshots? Or fireworks?"
        </p>
        <h2>Crowdsourcing the Answer</h2>
        <p>
          Think of this site as a specialized police scanner for your current location. It doesn't determine whether or not any given sound was <em>actually</em> gunfire. Instead, it checks to see if anyone <em>thinks</em> they heard gunfire, by checking in on reports to the Police.
        </p>
        <p>
          This is possible through SLMPD's feed of active <a href="http://www.slmpd.org/cfs.shtml"> calls for service</a>. Each call comes from various sources: 911 calls, non-emergency calls, other officers, or even <a href="http://www.shotspotter.com">gunfire-detecting robots</a>. The end result is kind of like a big to-do list, with each service call being removed whenever an officer has responded to the request.
        </p>
        <h2>Events</h2>
        <p>
          While the SLMPD displays a number of events, this site only tracks the ones that make a bang. Each event has a location, a time, an identification number, and a specific event type. The table below lists each event type tracked, along with more information about what qualifies for each type.
        </p>
        <div className="About-event-table">
          <table>
            <thead>
              <tr>
                <th>Event Name</th>
                <th>Notes</th>
              </tr>
            </thead>
            <tbody>
              {events.map(({title, rating, notes}) => (
                <tr key={title}>
                  <td>{title}</td>
                  <td>{notes}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

      </main>
    );
  }
}


export default About
