component extends="mxunit.framework.TestCase" {

	public void function setup() {

		stripe = new stripe.stripe( request.apiKey );

	}

	public void function testCreatePlan() {

		var plan = { id = createUUID(), amount = 1000, interval = 'month', interval_count = 3, name = "Gold Plan", metadata = { test = 'value' } };

		var result = stripe.createPlan( argumentCollection = plan );

		debug( result );

		assertEquals( 200, result.status_code, "expected a 200 status" );
		assertEquals( "plan", result.object, "plan object was not returned" );
		assertEquals( "value", result.metadata.test, "metadata was incorrect" );

	}

	public void function testGetPlan() {

		var plan = { id = createUUID(), amount = 5000, interval = "year", name = "Test Get Plan", trial_period_days = 15 };

		var planObject = stripe.createPlan( argumentCollection = plan );
		var result = stripe.getPlan( plan.id );

		debug( planObject );
		debug( result );

		assertEquals( 200, result.status_code, "expected a 200 status" );
		assertEquals( plan.id, result.id, "correct plan object was not returned" );
		assertEquals( plan.amount, result.amount, "correct plan object was not returned" );

	}

	public void function testUpdatePlan() {

		var plan = { id = createUUID(), amount = 5000, interval = "year", name = "Test Update Plan" };
		var newPlanName = "My New Plan Name";

		var planObject = stripe.createPlan( argumentCollection = plan );
		var result = stripe.updatePlan( id = plan.id, name = newPlanName );

		debug( planObject );
		debug( result );

		assertEquals( 200, result.status_code, "expected a 200 status" );
		assertEquals( plan.id, result.id, "correct plan object was not returned" );
		assertEquals( newPlanName, result.name, "plan was not updated correctly" );

	}	
	
	public void function testDeletePlan() {

		var plan = { id = createUUID(), amount = 5000, interval = "year", name = "Test Update Plan" };

		var planObject = stripe.createPlan( argumentCollection = plan );
		var result = stripe.deletePlan( plan.id );

		debug( planObject );
		debug( result );

		assertEquals( 200, result.status_code, "expected a 200 status" );
		assertEquals( plan.id, result.id, "correct plan object was not returned" );
		assertTrue( result.deleted, "plan was not deleted" );

	}

	public void function testListPlans() {

		var planOne = { id = createUUID(), amount = 500, interval = "month", name = "Test Update Plan One" };
		var planTwo = { id = createUUID(), amount = 5000, interval = "year", name = "Test Update Plan Two" };

		var planOneObject = stripe.createPlan( argumentCollection = planOne );
		var planTwoObject = stripe.createPlan( argumentCollection = planTwo );
		var result = stripe.listPlans( ending_before = planOneObject.id );

		debug( planOneObject );
		debug( planTwoObject );
		debug( result );

		assertEquals( 200, result.status_code, "expected a 200 status" );
		assertEquals( 1, arrayLen( result.data ), "correct plans are not listed" );

	}
	
}