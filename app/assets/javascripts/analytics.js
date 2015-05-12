(function() {
  function trackAnalyticsEvents() {

    var analyticsToTrack = JSON.parse(decodeURIComponent(monster.get('analytics')));

    if(analyticsToTrack.uuid) {
      analytics.identify(analyticsToTrack.uuid);
    }

    analyticsToTrack.events.forEach(function(analytics_event) {
      analytics.track(analytics_event.name);
    });

    analyticsToTrack.events = []
    monster.set('analytics', JSON.stringify(analyticsToTrack));
  }

  $(document).ready(trackAnalyticsEvents);
})()
