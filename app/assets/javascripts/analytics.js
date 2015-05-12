(function() {
  function trackAnalyticsEvents() {
    var analyticsToTrack = JSON.parse(decodeURIComponent(monster.get('analytics')));
    analyticsToTrack.events.forEach(function(analytics_event) {
      analytics.track(analytics_event.name);
    });

    analyticsToTrack.events = []
    monster.set('analytics', JSON.stringify(analyticsToTrack));
  }

  $(document).ready(trackAnalyticsEvents);
})()
