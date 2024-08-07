import React, { useState } from 'react';

const MailingListForm: React.FC = () => {
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const [isError, setIsError] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setMessage('');
    setIsError(false);
    setIsLoading(true);
  
    try {
      const formData = new FormData();
      formData.append('email', email);
  
      console.log('Sending request to /api/subscribe');
      const response = await fetch('/api/subscribe', {
        method: 'POST',
        body: formData,
      });
  
      console.log('Response status:', response.status);
      console.log('Response headers:', Object.fromEntries(response.headers));
  
      const text = await response.text();
      console.log('Response text:', text);
  
      let data;
      try {
        data = JSON.parse(text);
      } catch (error) {
        console.error('Error parsing JSON:', error);
        throw new Error('Invalid JSON response');
      }
  
      if (response.ok) {
        setMessage(data.message);
        setEmail('');
      } else {
        setIsError(true);
        setMessage(data.message || `Error: ${response.status} ${response.statusText}`);
      }
    } catch (error) {
      console.error('Error in handleSubmit:', error);
      setIsError(true);
      setMessage(`An error occurred: ${error instanceof Error ? error.message : 'Unknown error'}`);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="w-full max-w-md mx-auto bg-white shadow-md rounded-lg overflow-hidden">
      <div className="px-6 py-4">
        <h2 className="text-xl font-bold mb-2">Join my cult of personality</h2>
        <p className="mb-4">Each month or so, I usually send out a more personal mail out to my <s>cult</s> subscribers.</p>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="email"
            placeholder="Enter your email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            disabled={isLoading}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <button
            type="submit"
            disabled={isLoading}
            className="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50 disabled:opacity-50"
          >
            {isLoading ? 'Subscribing...' : 'Subscribe'}
          </button>
        </form>
        {message && (
        <div className={`mt-4 p-3 rounded ${isError ? 'bg-red-100 text-red-700' : 'bg-green-100 text-green-700'}`}>
          {message}
        </div>
      )}
      </div>
    </div>
  );
};

export default MailingListForm;