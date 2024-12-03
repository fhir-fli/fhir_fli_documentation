import React from 'react';
import Layout from '@theme/Layout';

export default function Contact() {
  return (
    <Layout title="Contact">
      <div style={{ padding: '2rem' }}>
        <h1>Contact</h1>
        <p><strong>Name:</strong> Jason Grey Faulkenberry, MD MPH</p>
        <p><strong>Email:</strong> <a href="mailto:grey@fhirfli.dev">grey@fhirfli.dev</a></p>
      </div>
    </Layout>
  );
}
